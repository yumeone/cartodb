<template>
  <QuickActions
    :actions="actions[actionMode]"
    v-on="getEventListeners()"
    ref="quickActions"
    @open="openQuickactions"
    @close="closeQuickactions" />
</template>

<script>
import { mapGetters } from 'vuex';
import * as Table from 'new-dashboard/core/models/table';
import QuickActions from 'new-dashboard/components/QuickActions/QuickActions';
import * as DialogActions from 'new-dashboard/core/dialog-actions';

export default {
  name: 'DatasetQuickActions',
  inject: ['backboneViews'],
  components: {
    QuickActions
  },
  props: {
    dataset: Object,
    storeActionType: {
      type: String,
      default: 'datasets'
    },
    isSharedWithMe: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    ...mapGetters({
      isOutOfDatasetsQuota: 'user/isOutOfDatasetsQuota',
      isOutOfPublicMapsQuota: 'user/isOutOfPublicMapsQuota',
      isOutOfPrivateMapsQuota: 'user/isOutOfPrivateMapsQuota'
    }),
    actions () {
      return {
        mine: [
          {
            name: this.$t('QuickActions.createMap'),
            event: 'createMap',
            shouldBeDisabled: this.isOutOfPrivateMapsQuota
          },
          {
            name: this.$t('QuickActions.editInfo'),
            event: 'editInfo',
            shouldBeHidden: this.isDOSubscription
          },
          {
            name: this.$t('QuickActions.manageTags'),
            event: 'manageTags'
          },
          {
            name: this.$t('QuickActions.changePrivacy'),
            event: 'changePrivacy'
          },
          {
            name: this.$t('QuickActions.share'),
            event: 'shareVisualization',
            shouldBeHidden: !this.isUserInsideOrganization
          },
          {
            name: this.$t('QuickActions.duplicate'),
            event: 'duplicateDataset',
            shouldBeDisabled: this.isOutOfDatasetsQuota
          },
          {
            name: this.$t('QuickActions.lock'),
            event: 'lockDataset',
            shouldBeHidden: this.isDOSubscription
          },
          {
            name: this.$t('QuickActions.delete'),
            event: 'deleteDataset',
            shouldBeHidden: this.isDOSubscription,
            isDestructive: true
          }
        ],
        shared: [
          {
            name: this.$t('QuickActions.createMap'),
            event: 'createMap'
          },
          {
            name: this.$t('QuickActions.duplicate'),
            event: 'duplicateDataset'
          }
        ],
        locked: [
          {
            name: this.$t('QuickActions.duplicate'),
            event: 'duplicateDataset'
          },
          {
            name: this.$t('QuickActions.unlock'),
            event: 'unlockDataset'
          }
        ]
      };
    },
    actionMode () {
      if (this.dataset.locked) {
        return 'locked';
      }
      if (this.isSharedWithMe) {
        return 'shared';
      }
      return 'mine';
    },
    isUserInsideOrganization () {
      const userOrganization = this.$store.state.user.organization;
      return userOrganization && userOrganization.id;
    },
    isDOSubscription () {
      const subscription = this.dataset.subscription;
      return subscription && subscription.provider === 'do-v2';
    }
  },
  methods: {
    getActionHandlers () {
      return {
        deselectAll: () => {},
        fetchList: () => {
          this.$store.dispatch(`${this.storeActionType}/fetch`);
          this.$emit('contentChanged', 'datasets');
        },
        updateVisualization: (model) => {
          this.$store.dispatch(`${this.storeActionType}/updateVisualization`, { visualizationId: model.get('id'), visualizationAttributes: model.attributes });
        }
      };
    },
    getEventListeners () {
      const events = this.actions[this.actionMode].map(action => action.event);

      return events.reduce(
        (eventListeners, action) => {
          eventListeners[action] = this[action].bind(this);
          return eventListeners;
        }, {}
      );
    },
    showModal (componentDefinition, componentPropsData) {
      this.$modal.show(
        componentDefinition,
        componentPropsData,
        { width: '100%', height: '100%' }
      );
    },
    openQuickactions () {
      this.$emit('open');
    },
    closeQuickactions () {
      this.$emit('close');
    },
    closeDropdown () {
      this.$refs.quickActions.closeDropdown();
    },
    editInfo () {
      DialogActions.editDatasetMetadata.apply(this, [this.dataset, this.getActionHandlers()]);
      this.closeDropdown();
    },
    createMap () {
      DialogActions.createMap.apply(this, [
        [this.dataset],
        this.backboneViews.backgroundPollingView.getBackgroundPollingView(),
        this.backboneViews.mamufasImportView.getView()
      ]);
    },
    changePrivacy () {
      DialogActions.changePrivacy.apply(this, [this.dataset, this.getActionHandlers()]);
      this.closeDropdown();
    },
    manageTags () {
      DialogActions.editDatasetMetadata.apply(this, [this.dataset, this.getActionHandlers()]);
      this.closeDropdown();
    },
    duplicateDataset () {
      const bgPollingView = this.backboneViews.backgroundPollingView.getBackgroundPollingView();

      bgPollingView._addDataset({
        type: 'duplication',
        table_name: `${Table.getUnqualifiedName(this.dataset.name)}_copy`,
        value: this.dataset.table.name,
        create_vis: false
      });
      this.closeDropdown();
    },
    unlockDataset () {
      DialogActions.changeLockState.apply(this, [this.dataset, 'datasets', this.getActionHandlers()]);
      this.closeDropdown();
    },
    lockDataset () {
      DialogActions.changeLockState.apply(this, [this.dataset, 'datasets', this.getActionHandlers()]);
      this.closeDropdown();
    },
    deleteDataset () {
      DialogActions.deleteVisualization.apply(this, [this.dataset, 'datasets', this.getActionHandlers()]);
      this.closeDropdown();
    },
    shareVisualization () {
      DialogActions.shareVisualization.apply(this, [this.dataset, this.getActionHandlers()]);
      this.closeDropdown();
    }
  }
};
</script>
