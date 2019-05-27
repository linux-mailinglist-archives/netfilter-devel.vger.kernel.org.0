Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87C32BB97
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfE0U70 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 16:59:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfE0U70 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 16:59:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so17979533wrx.0
        for <netfilter-devel@vger.kernel.org>; Mon, 27 May 2019 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hJRqaTxm14GN0raj7KzirSzFjuA2QyTiTh25MeIywco=;
        b=s6m7NFOeqbfNaXQq7GcK8kyEAAtRTY8ndgEyhXrHGODA968hL6K6ntpo+54XcWedj3
         e3se/ZDYOdRnnITbjVuY257kUZmHkxDQUfrI+8ufE7+oSjAA6ZmVndshl7w3Ks6BtpTg
         DLLKF7LlLk7oN9jHM3LkG3axlUcvE8GJJWzVH1UylM/beS4JgBohjuaUlGNXyw2Ge4l4
         FToDVJPnM7z8YO0g/q4Eldfy9ot8UJOyYzDodtKOfKm/lztrzPsvasyRt/xWYZGaZ/EW
         O9SK2pnZKwAAZfTnC6JoUMFNaObRAekTSexx1Fy4KKGPs5F2SZF5eb2uDfAHvCw0mFQY
         o0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hJRqaTxm14GN0raj7KzirSzFjuA2QyTiTh25MeIywco=;
        b=AD74RKeaoDopWF6MSEqzAFd2KAO7YhH127KpHnIkRpt1Xw7M/gSAWmlbjafI8ySf+o
         trYKCZ4xpp8oxvLavyGNE+yHDNryHm3m8SCMPUpqJk+79mJl12Q+b5OR/Df0RbpfK6ll
         fYK4tuGnO+h+9Ey1r6bMcI1jVwM/ZMyZJOXk+bVU/7mBXs2rnJC/Cdavhn5IeFOhMgtK
         hxZZGlhY9v+FW3toVXe90gWo6mIbmnJ5mhRkvHoE6ZzxD89YfI5LgaigXnRDOM+arjZS
         GLIUCcXe73Izg0RbOgCRDOYGkhjEMMVXbKN4yDjUNL+ub4pqPoNglxHSDVs96aKx2nFW
         Mw9A==
X-Gm-Message-State: APjAAAWWhfhxhIrhgyWu3rhiutUKaAZoHesTkQ1F06qBznBEIrRvcQSf
        l3cQOzqPxTvM1sa7Ciqc5MZiUwmG
X-Google-Smtp-Source: APXvYqzMCqqjhouwfLgBLVs5BTUeMUNImKXjCRE+IEa9RKs6ULI7yCvETgV8AVrs9OM2XeaP5QR67Q==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr51821138wrn.34.1558990765056;
        Mon, 27 May 2019 13:59:25 -0700 (PDT)
Received: from ash-clevo (80.104.199.146.dyn.plus.net. [146.199.104.80])
        by smtp.gmail.com with ESMTPSA id p17sm12155622wrq.95.2019.05.27.13.59.24
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 13:59:24 -0700 (PDT)
Date:   Mon, 27 May 2019 21:59:23 +0100
From:   Ash Hughes <sehguh.hsa@gmail.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] conntrackd: search for RPC headers
Message-ID: <20190527205923.GA16360@ash-clevo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Attempts to get RPC headers from libtirpc if they aren't otherwise available.

Signed-off-by: Ash Hughes <sehguh.hsa@gmail.com>
---
 configure.ac            | 2 ++
 src/helpers/Makefile.am | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 048d261..cb9659f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,6 +50,8 @@ AC_ARG_ENABLE([systemd],
         AS_HELP_STRING([--enable-systemd], [Build systemd support]),
         [enable_systemd="$enableval"], [enable_systemd="no"])
 
+AC_CHECK_HEADER([rpc/rpc_msg.h], [AC_SUBST([LIBTIRPC_CFLAGS],'')], [PKG_CHECK_MODULES([LIBTIRPC], [libtirpc])])
+
 PKG_CHECK_MODULES([LIBNFNETLINK], [libnfnetlink >= 1.0.1])
 PKG_CHECK_MODULES([LIBMNL], [libmnl >= 1.0.3])
 PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.7])
diff --git a/src/helpers/Makefile.am b/src/helpers/Makefile.am
index 05801bc..51e2841 100644
--- a/src/helpers/Makefile.am
+++ b/src/helpers/Makefile.am
@@ -31,7 +31,7 @@ ct_helper_mdns_la_CFLAGS = $(HELPER_CFLAGS)
 
 ct_helper_rpc_la_SOURCES = rpc.c
 ct_helper_rpc_la_LDFLAGS = $(HELPER_LDFLAGS)
-ct_helper_rpc_la_CFLAGS = $(HELPER_CFLAGS)
+ct_helper_rpc_la_CFLAGS = $(HELPER_CFLAGS) @LIBTIRPC_CFLAGS@
 
 ct_helper_tftp_la_SOURCES = tftp.c
 ct_helper_tftp_la_LDFLAGS = $(HELPER_LDFLAGS)
-- 
2.21.0

