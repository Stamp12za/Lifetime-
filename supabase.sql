-- MY LIFE ONLINE — Supabase setup
-- Run this whole script in Supabase Dashboard > SQL Editor.
-- IMPORTANT: never put a service_role key in index.html.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default 'ผู้เล่น',
  avatar text not null default '🧑🏻',
  created_at timestamptz not null default now()
);

create table if not exists public.games (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists public.leaderboard (
  user_id uuid primary key references auth.users(id) on delete cascade,
  name text not null default 'ผู้เล่น',
  avatar text not null default '🧑🏻',
  age int not null default 18,
  money bigint not null default 0,
  happiness int not null default 0,
  knowledge int not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.games enable row level security;
alter table public.leaderboard enable row level security;

-- Remove broad grants, then grant only what this browser game needs.
revoke all on table public.profiles from anon, authenticated;
revoke all on table public.games from anon, authenticated;
revoke all on table public.leaderboard from anon, authenticated;

grant select, insert, update on table public.profiles to authenticated;
grant select, insert, update on table public.games to authenticated;
grant select, insert, update on table public.leaderboard to authenticated;

drop policy if exists "profile_select_own" on public.profiles;
drop policy if exists "profile_insert_own" on public.profiles;
drop policy if exists "profile_update_own" on public.profiles;
create policy "profile_select_own" on public.profiles for select to authenticated
using ((select auth.uid()) = id);
create policy "profile_insert_own" on public.profiles for insert to authenticated
with check ((select auth.uid()) = id);
create policy "profile_update_own" on public.profiles for update to authenticated
using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

drop policy if exists "game_select_own" on public.games;
drop policy if exists "game_insert_own" on public.games;
drop policy if exists "game_update_own" on public.games;
create policy "game_select_own" on public.games for select to authenticated
using ((select auth.uid()) = user_id);
create policy "game_insert_own" on public.games for insert to authenticated
with check ((select auth.uid()) = user_id);
create policy "game_update_own" on public.games for update to authenticated
using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

-- Leaderboard is intentionally public to signed-in players.
drop policy if exists "leaderboard_read" on public.leaderboard;
drop policy if exists "leaderboard_insert_own" on public.leaderboard;
drop policy if exists "leaderboard_update_own" on public.leaderboard;
create policy "leaderboard_read" on public.leaderboard for select to authenticated
using (true);
create policy "leaderboard_insert_own" on public.leaderboard for insert to authenticated
with check ((select auth.uid()) = user_id);
create policy "leaderboard_update_own" on public.leaderboard for update to authenticated
using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

create index if not exists games_user_id_idx on public.games(user_id);
create index if not exists leaderboard_money_idx on public.leaderboard(money desc);
