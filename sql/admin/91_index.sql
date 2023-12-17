ALTER TABLE `visit_history`
ADD
    INDEX `visit_history_multi_index` (
        `tenant_id`,
        `competition_id`,
        `created_at`
    );