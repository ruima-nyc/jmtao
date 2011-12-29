class TaobaoItem < ActiveRecord::Base
        include TypoGuid

	belongs_to	:article
	belongs_to :resource
        #before_create :create_guid

        attr_accessor :guid

        def image_url()
          if self.resource
            "/files/#{self.resource.filename}"
          end
        end

        def add_http(url)
          if /^http/ !~ url
            tmp = "http://"+url
          else
            tmp = url
          end
          tmp
        end

        def url=(url)
          self[:url] = add_http(url)
          self[:url]
        end

        def url()
          add_http(self[:url])
        end


        def image_url=(taobao_url)
          create_guid
          taobao_url = add_http(taobao_url)
          self.resource = Resource.create(:filename => self.guid+'.jpg',:mime => 'image', :created_at => Time.now).write_to_disk(taobao_url)
        end
end
