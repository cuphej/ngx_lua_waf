yum -y install gcc gcc-c++ autoconf automake make vim wget unzip
cd /opt 
wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar zxf LuaJIT-2.0.5.tar.gz && LuaJIT-2.0.5/
make install PREFIX=/usr/local/luajit
echo "LUAJIT_LIB=/usr/local/luajit/lib" >> /etc/environment
echo "LUAJIT_INC=/usr/local/luajit/include/luajit-2.0" >> /etc/environment
yum install -y lua-devel 

cd /opt 
wget https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1rc1.tar.gz && tar zxf v0.3.1rc1.tar.gz -C /opt
cd /opt
wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz && tar zxf v0.10.13.tar.gz -C /opt
cd /opt
wget http://downloads.sourceforge.net/project/pcre/pcre/8.39/pcre-8.39.tar.gz && tar zxf pcre-8.39.tar.gz -C /opt
cd /opt 
wget https://www.openssl.org/source/openssl-1.0.2j.tar.gz && tar zxf openssl-1.0.2j.tar.gz -C /opt
cd /opt
wget http://zlib.net/zlib-1.2.11.tar.gz && tar zxf zlib-1.2.11.tar.gz -C /opt
cd /opt
wget http://nginx.org/download/nginx-1.10.3.tar.gz
tar -xzvf nginx-1.10.3.tar.gz

cd nginx-1.10.3
./configure \
--prefix=/usr/local/nginx \
--add-module=/opt/ngx_devel_kit-0.3.1rc1 \
--add-module=/opt/lua-nginx-module-0.10.13 \
--with-pcre=/opt/pcre-8.39 \
--with-openssl=/opt/openssl-1.0.2j \
--with-zlib=/opt/zlib-1.2.11 \
--with-http_gzip_static_module \
--with-http_ssl_module
make -j2 && make install
ln -sf /usr/local/nginx/sbin/nginx /usr/bin/nginx
ln -sf /usr/local/luajit/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2


cd /opt/
wget https://github.com/weakestan/ngx_lua_waf/archive/master.zip --no-check-certificate
unzip master.zip
mv ngx_lua_waf-master/* /usr/local/nginx/conf/waf/
#mv -f /opt/nginx.conf /usr/local/nginx/conf
rm -rf ngx_lua_waf-master
#rm -rf /opt/*
mkdir -p /data/logs/hack
chmod -R 775 /data/logs/hack
