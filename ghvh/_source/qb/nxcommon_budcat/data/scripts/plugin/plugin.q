
script plugin_quickview 
	spawnscriptnow plugin_quickview_spawned params = <...>
endscript

script plugin_quickview_spawned 

	stoprendering
	finishrendering
	wait \{3
		gameframes}
	killtexturesplats \{all}
	if (<export_type> = scene)

		<export_type> = zone
	endif
	switch <export_type>
		case sky
		switch <project>
			case gun2
			tod_change_sky sky = <sky>
			default
			change_sky sky = <sky>
		endswitch
		case zone
		switch <project>
			case 0x1e5e2013

			getpakmancurrentname \{map = zones}
			setpakmancurrentblock \{map = zones
				pak = none}
			refreshpakmansizes \{map = zones}
			setpakmancurrentblock map = zones pakname = <pakname>

			case gun2
			getpakmancurrentname \{map = zones}
			zone_name = <pakname>
			formattext textname = zone qs(0xa2f2c278) z = <zone> dontassertforchecksums
			if NOT (<zone_name> = <zone>)
				jumptozone zone = <zone>
			else
				blockpendingpakmanloads \{map = zones}
				refreshcurrentzones
			endif
			default
			if NOT (<zone> = viewer)
				formattext checksumname = zone 'load_%z' z = <zone> dontassertforchecksums
			endif
			getcurrentlevel
			if NOT (<level> = <zone>)
				setpakmancurrentblock \{map = zones
					pak = none}
				change_level level = <zone>
			else
				blockpendingpakmanloads \{map = zones}
				refreshcurrentzones
			endif
		endswitch
		case viewer
		switch <project>
			case 0x1e5e2013

			getpakmancurrentname \{map = zones}
			setpakmancurrentblock \{map = zones
				pak = none}
			refreshpakmansizes \{map = zones}
			setpakmancurrentblock map = zones pakname = <pakname>

			case gun2
			getmissionname
			if NOT (<mission> = viewer)
				load_new_mission mission_pak = <viewer> reload_zones
			else
				blockpendingpakmanloads \{map = zones}
				refreshcurrentzones
			endif
			case gh3

			select_venue \{norestart
				level = viewer}

			case gh3_demo

			select_venue \{norestart
				level = viewer}

			case gh4

			select_venue \{norestart
				level = viewer}

			default
			getcurrentlevel
			if NOT (<level> = viewer)
				setpakmancurrentblock \{map = zones
					pak = none}
				change_level \{level = viewer}
			else
				blockpendingpakmanloads \{map = zones}
				refreshcurrentzones
			endif
		endswitch
		case mission
		switch <project>
			case gun2

			load_new_mission mission_pak = <mission> reload_zones
			default
			blockpendingpakmanloads \{map = zones}
			refreshcurrentzones
		endswitch
		case model
		change \{view_mode = 0}
		toggleviewmode
		toggleviewmode
		toggleviewmode
		exit_view_models_menu
		toggle_model_viewer
		view_model modelname = <model>
		case skin
		change \{view_mode = 0}
		toggleviewmode
		toggleviewmode
		toggleviewmode
		exit_view_models_menu
		toggle_model_viewer
		view_model \{profile = ped_batmasterson
			animloadscript = animload_ped_male
			extraanim = animload_ped_male
			defaultanim = mv_idle_denton
			skeletonname = gun}
		default
	endswitch
	if nodeflagexists \{nodeflag_viewerlights}
		changenodeflag \{nodeflag_viewerlights
			0}
		changenodeflag \{nodeflag_viewerlights
			1}
	endif
	startrendering
	kill_panel_message_if_it_exists \{id = quickview}
endscript
