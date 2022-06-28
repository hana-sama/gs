-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Spells:     [ ALT+, ]           Sneak/Spectral Jig/Silent Oil
--              [ ALT+. ]           Invisible/Prism Powder
--              [ ALT+Numpad7 ]     Paralyna
--              [ ALT+Numpad8 ]     Silena
--              [ ALT+Numpad9 ]     Blindna
--              [ ALT+Numpad4 ]     Poisona
--              [ ALT+Numpad5 ]     Stona
--              [ ALT+Numpad6 ]     Viruna
--              [ ALT+Numpad1 ]     Cursna
--              [ ALT+Numpad+ ]     Erase
--              [ ALT+Numpad0 ]     Sacrifice
--              [ ALT+Numpad. ]     Esuna
--
--  Items:      [ WIN+Numpad/ ]     Soldier's Drink
--              [ WIN+Numpad7 ]     Remedy
--              [ WIN+Numpad8 ]     Echo Drops
--              [ WIN+Numpad9 ]     Eye Drops
--              [ WIN+Numpad4 ]     Antidote
--              [ WIN+Numpad6 ]     Remedy
--              [ WIN+Numpad1 ]     Holy Water
--              [ WIN+Numpad0 ]     Catholican +1
--              [ WIN+Numpad. ]     Catholican
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------

    -- Default Spell HotKeys
    if player.main_job == 'DNC' or player.sub_job == 'DNC' then
      send_command('bind ^, input /ja '..windower.to_shift_jis("Spectral Jig")..' <me>')
      send_command('unbind ^.')
  elseif player.main_job == 'RDM' or player.sub_job == 'RDM'
      or player.main_job == 'SCH' or player.sub_job == 'SCH'
      or player.main_job == 'WHM' or player.sub_job == 'WHM' then
      send_command('bind ^, input /ma '..windower.to_shift_jis("Sneak")..' <stpc>')
      send_command('bind ^. input /ma '..windower.to_shift_jis("Invisible")..' <stpc>')
  else
      send_command('bind ^, input /item '..windower.to_shift_jis("Silent Oil")..' <me>')
      send_command('bind ^. input /item '..windower.to_shift_jis("Prism Powder")..' <me>')
  end

  send_command('bind @, input /ma '..windower.to_shift_jis("Utsusemi: Ichi")..' <me>')
  send_command('bind @. input /ma '..windower.to_shift_jis("Utsusemi: Ni")..' <me>')

  -- Default Enhancing HotKeys
  send_command('bind !e input /ma '..windower.to_shift_jis("Haste")..' <stpc>')
  send_command('bind !r input /ma '..windower.to_shift_jis("Refresh")..' <stpc>')
  send_command('bind !t input /ma '..windower.to_shift_jis("Blink")..' <me>')
  send_command('bind !y input /ma '..windower.to_shift_jis("Phalanx")..' <me>')
  send_command('bind !u input /ma '..windower.to_shift_jis("Stoneskin")..' <me>')
  send_command('bind !i input /ma '..windower.to_shift_jis("Aquaveil")..' <me>')
  send_command('bind !o input /ma '..windower.to_shift_jis("Cure IV")..' <stpc>')

  -- Default Status Cure HotKeys
  send_command('bind !numpad7 input /ma '..windower.to_shift_jis("Paralyna")..' <t>')
  send_command('bind !numpad8 input /ma '..windower.to_shift_jis("Silena")..' <t>')
  send_command('bind !numpad9 input /ma '..windower.to_shift_jis("Blindna")..' <t>')
  send_command('bind !numpad4 input /ma '..windower.to_shift_jis("Poisona")..' <t>')
  send_command('bind !numpad5 input /ma '..windower.to_shift_jis("Stona")..' <t>')
  send_command('bind !numpad6 input /ma '..windower.to_shift_jis("Viruna")..' <t>')
  send_command('bind !numpad1 input /ma '..windower.to_shift_jis("Cursna")..' <t>')
  send_command('bind !numpad+ input /ma '..windower.to_shift_jis("Erase")..' <t>')
  send_command('bind !numpad0 input /ma '..windower.to_shift_jis("Sacrifice")..' <t>')
  send_command('bind !numpad. input /ma '..windower.to_shift_jis("Esuna")..' <me>')

  -- Default Status Enfeebling HotKeys
  send_command('bind ~numpad7 input /ma '..windower.to_shift_jis("Paralyze")..' <t>')
  send_command('bind ~numpad8 input /ma '..windower.to_shift_jis("Silence")..' <t>')
  send_command('bind ~numpad9 input /ma '..windower.to_shift_jis("Blind")..' <t>')
  send_command('bind ~numpad4 input /ma '..windower.to_shift_jis("Poison")..' <t>')
  send_command('bind ~numpad5 input /ma '..windower.to_shift_jis("Slow")..' <t>')
  send_command('bind ~numpad6 input /ma '..windower.to_shift_jis("Addle")..' <t>')
  send_command('bind ~numpad1 input /ma '..windower.to_shift_jis("Distract")..' <t>')
  send_command('bind ~numpad2 input /ma '..windower.to_shift_jis("Frazzle")..' <t>')
  send_command('bind ~numpad0 input /ma '..windower.to_shift_jis("Dia II")..' <t>')

  -- Default Item HotKeys
  send_command('bind @numpad7 input /item '..windower.to_shift_jis("Remedy")..' <me>')
  send_command('bind @numpad8 input /item '..windower.to_shift_jis("Echo Drops")..' <me>')
  send_command('bind @numpad9 input /item '..windower.to_shift_jis("Eye Drops")..' <me>')
  send_command('bind @numpad4 input /item '..windower.to_shift_jis("Antidote")..' <me>')
  send_command('bind @numpad6 input /item '..windower.to_shift_jis("Remedy")..' <me>')
  send_command('bind @numpad1 input /item '..windower.to_shift_jis("Holy Water")..' <me>')

  -- Dual Box Key Binds (Requires Send and Shortcuts)
  send_command('bind #f1 input //send @others //setkey f1 down;wait 0.1;input //send @others //setkey f1 up')
  send_command('bind #f2 input //send @others //setkey f2 down;wait 0.1;input //send @others //setkey f2 up')
  send_command('bind #f3 input //send @others //setkey f3 down;wait 0.1;input //send @others //setkey f3 up')
  send_command('bind #f4 input //send @others //setkey f4 down;wait 0.1;input //send @others //setkey f4 up')
  send_command('bind #f5 input //send @others //setkey f5 down;wait 0.1;input //send @others //setkey f5 up')
  send_command('bind #f6 input //send @others //setkey f6 down;wait 0.1;input //send @others //setkey f6 up')
  send_command('bind #f7 input //send @others /follow <p1>')
  send_command('bind #f8 input //send @others /ta <bt>')

  send_command('bind #escape input //send @others //setkey escape down;wait 0.1;input //send @others //setkey escape up')
  send_command('bind #enter input //send @others //setkey enter down;wait 0.1;input //send @others //setkey enter up')
  send_command('bind #tab input //send @others //setkey tab down;wait 0.1;input //send @others //setkey tab up')

  send_command('bind #up down input //send @others //setkey up down')
  send_command('bind #up up input //send @others //setkey up up')
  send_command('bind #down down input //send @others //setkey down down')
  send_command('bind #down up input //send @others //setkey down up')
  send_command('bind #left down input //send @others //setkey left down')
  send_command('bind #left up input //send @others //setkey left up')
  send_command('bind #right down input //send @others //setkey right down')
  send_command('bind #right up input //send @others //setkey right up')

  send_command('bind #- input //send @others /follow <t>')
  send_command('bind #= input //send @others //setkey numpad7 down;wait 0.2;input //send @others //setkey numpad7 up')

  send_command('bind #f10 input //send @others //gs c cycle defensemode')
  send_command('bind #f11 input //send @others //gs c cycle castingmode')
  send_command('bind #f12 input //send @others //gs c cycle idlemode')