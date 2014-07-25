# This is a template; feel free to change it.
# For more details, check out http://docs.zillabyte.com/quickstart/hello_world/

require 'zillabyte' 

Zillabyte.app("crawler_checker")
  .source("select * from web_pages")
  .each{ |page|
    has_salonmonster = 0
    has_vcita = 0
    has_google_adsense = 0
    if page['html'].include? "http://www.vcita.com/integrations/wix/widget"
      has_salonmonster = 1
    end
    if page['html'].include? "salonmonster.com"
      has_vcita = 1
    end
    if page['html'].include? "google_ad_client ="
      has_google_adsense = 1
    end
    emit :url => page['url'] , :has_vcita => has_vcita, :has_salonmonster => has_salonmonster, :has_google_adsense => has_google_adsense
  }
  .sink{
    name "results"
    column "url", :string
    column "has_vcita", :integer
    column "has_salonmonster", :integer
    column "has_google_adsense", :integer
  }