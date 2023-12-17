CREATE INDEX competition_idx ON competition(tenant_id);
CREATE INDEX player_idx ON player(tenant_id);
CREATE INDEX player_score_idx ON player_score(tenant_id, player_id, competition_id);
