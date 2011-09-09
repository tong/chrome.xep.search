package chrome.xep;

class Options {
	
	static var app : chrome.xep.IApp;
	
	static function init() {
	
		app = chrome.Extension.getBackgroundPage().instance;
		
		#if DEBUG
		haxe.Log.trace = mytrace;
		trace( "chrome.xep.options" );
		#end
		
		j( '#info' ).hide();
		
		var j_reload = j( '#btn_loadapi' );
		j_reload.click(function(e) {
			j_reload.hide();
			haxe.Timer.delay( function(){
				app.updateXEPsDescription( function(err){
					if( err != null ) {
						j( '#info' ).css("backgroundColor","#ff0000").html( 'ERROR reloading XEP description: '+err ).slideDown(200).delay(2000).slideUp(200);
					} else {
						j( '#info' ).css("backgroundColor","#ccc").html( 'XEP description reloaded' ).slideDown(200).delay(2000).slideUp(200);
					}
					j_reload.show();
				});
			}, 1 );
		});
		
		/*
		for( f in app.xepStatusFilters )
			j( '#statusfilter_'+XEPDescription.getXEPStatusString(f) ).attr( 'checked', 'true' );
		for( f in Type.getClassFields( XEPStatus ) ) {
			var i = XEPDescription.getXEPStatus(f.toLowerCase());
			var e = j( '#statusfilter_'+f.toLowerCase() );
			e.change( function(_){
				if( e.is(':checked') ) {
					app.xepStatusFilters.push( i );
				} else {
					app.xepStatusFilters.remove( i );
				}
				Storage.setObject( "xep_status_filters", app.xepStatusFilters );
			});
		}
		*/
		
		/*
		for( f in app.xepStatusFilters ) {
			j( '#statusfilter_'+Type.enumConstructor(f) ).attr( 'checked', "true" );
		}
		for( f in Type.getEnumConstructs( XEPStatus ) ) {
			var e = j( '#statusfilter_'+f );
			e.change( function(_){
				var status = Type.createEnum( XEPStatus, f );
				if( e.is(':checked') ) {
					if( !xepStatusFilterActive( status ) ) {
						app.xepStatusFilters.push( status );
						Storage.setObject( "xep_status_filters", app.xepStatusFilters );
					}
				} else {
					if( xepStatusFilterActive( status ) ) {
						app.xepStatusFilters.remove( status );
						Storage.setObject( "xep_status_filters", app.xepStatusFilters );
					}
				}
				for( f in app.xepStatusFilters ) trace(f);
			});
		}
		*/
	}
	
	/*
	static function xepStatusFilterActive( s : XEPStatus ) : Bool {
		for( f in app.xepStatusFilters ) {
			if( Type.enumIndex(f ) == Type.enumIndex(s) )
				return true;
		}
		return false;
	} 
	*/
	
	/* 
	static function updateXEPStatusFilterSetting( s : String ) {
		var f = 'use'+field+'Search'; 
		var e = j( '#'+field.toLowerCase()+'search' );
		e.attr( 'checked', ( Reflect.field( app, f ) ) ? "true" : null );
		e.change(function(ev){
			Reflect.setField( app, f, e.is( ':checked' ) );
			Settings.save( app );
		});
	}
	*/
	
	static inline function j( id : Dynamic ) : js.JQuery { return new js.JQuery( id ); }
	
	#if DEBUG
	static inline function mytrace( v : Dynamic, ?inf : haxe.PosInfos ) { app.log( v, inf ); }
    #end
	
}
