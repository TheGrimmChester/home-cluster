data "cloudflare_zone" "clouded_fr" {
  name = "clouded.fr"
}

resource "cloudflare_record" "clouded_fr_apex" {
  name    = "ipv4"
  zone_id = data.cloudflare_zone.clouded_fr.id
  value   = chomp(data.http.ipv4.response_body)
  proxied = false
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "clouded_fr_root" {
  name    = "clouded.fr"
  zone_id = data.cloudflare_zone.clouded_fr.id
  value   = "ipv4.clouded.fr"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "clouded_fr_www" {
  name    = "www"
  zone_id = data.cloudflare_zone.clouded_fr.id
  value   = "ipv4.clouded.fr"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "clouded_fr_public_cname" {
  name    = data.sops_file.secrets.data["cloudflare_unproxied_cname"]
  zone_id = data.cloudflare_zone.clouded_fr.id
  value   = "ipv4.clouded.fr"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}
#
#resource "cloudflare_page_rule" "clouded_fr_plex_bypass" {
#  zone_id  = data.cloudflare_zone.clouded_fr.id
#  target   = "https://plex.clouded.fr./*"
#  status   = "active"
#  priority = 1
#
#  actions {
#    cache_level              = "bypass"
#    rocket_loader            = "off"
#    automatic_https_rewrites = "on"
#  }
#}
#
#resource "cloudflare_page_rule" "clouded_fr_home_assistant_bypass" {
#  zone_id  = data.cloudflare_zone.clouded_fr.id
#  target   = "https://hass.clouded.fr./*"
#  status   = "active"
#  priority = 2
#
#  actions {
#    cache_level              = "bypass"
#    rocket_loader            = "off"
#    automatic_https_rewrites = "on"
#  }
#}

resource "cloudflare_zone_settings_override" "clouded_fr_settings" {
  zone_id = data.cloudflare_zone.clouded_fr.id
  settings {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    tls_1_3                  = "zrt"
    automatic_https_rewrites = "on"
    universal_ssl            = "on"
    browser_check            = "on"
    challenge_ttl            = 1800
    privacy_pass             = "on"
    security_level           = "medium"
    brotli                   = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
    rocket_loader       = "off"
    always_online       = "off"
    development_mode    = "off"
    http3               = "on"
    zero_rtt            = "on"
    ipv6                = "on"
    websockets          = "on"
    opportunistic_onion = "on"
    pseudo_ipv4         = "off"
    ip_geolocation      = "on"
    email_obfuscation   = "on"
    server_side_exclude = "on"
    hotlink_protection  = "off"
    security_header {
      enabled = false
    }
  }
}
