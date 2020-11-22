Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307892BC5F6
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgKVOFg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 09:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgKVOFf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:05:35 -0500
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49ABC0613CF
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bUgnqFtotSyiMQolKv7qZFhEukqfTIgIkEIZvqb8AOc=; b=GPGHf7IEEY9xZMZaeHf8S8z81q
        ZFuLh5pArPsdw9Zniyud/ohPLCetD2RycJaQ/OoJ+W+96si2CpSNiez3cLAYo7x4iU3OLgacOXNQI
        HmvnKh1hnkkdh4KbHzGQomu+T27c1YV9Gm7PEg51zEAieXYeRGaWV1O787R2+l+fmcetImhLh6dT3
        vjVcz3r0AKwOUka+jycUp1D1tsH/qGTCX/wr1DEDAj9ULf/kKFUAimCfu6uXSkaYlihLQvQ4b84uD
        Alw8VFP6R0cicVZGd48QLBcZaL6womLmF1ObKJxLzkTliELnPPoV/FuFHj/Yk7iN6Qj/8FUd8xOiQ
        4LkrD4YA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kgpzf-0002wq-4f; Sun, 22 Nov 2020 14:05:31 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons 0/4] geoip: script fixes
Date:   Sun, 22 Nov 2020 14:05:26 +0000
Message-Id: <20201122140530.250248-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A couple of fixes and some man-pages for the MaxMind geoip scripts.

Jeremy Sowden (4):
  geoip: remove superfluous xt_geoip_fetch_maxmind script.
  geoip: fix man-page typo'.
  geoip: add man-pages for MaxMind scripts.
  geoip: use correct download URL for MaxMind DB's.

 geoip/Makefile.am              |  6 ++-
 geoip/xt_geoip_build_maxmind.1 | 40 ++++++++++++++
 geoip/xt_geoip_dl_maxmind      | 12 ++++-
 geoip/xt_geoip_dl_maxmind.1    | 22 ++++++++
 geoip/xt_geoip_fetch.1         |  2 +-
 geoip/xt_geoip_fetch_maxmind   | 95 ----------------------------------
 6 files changed, 77 insertions(+), 100 deletions(-)
 create mode 100644 geoip/xt_geoip_build_maxmind.1
 create mode 100644 geoip/xt_geoip_dl_maxmind.1
 delete mode 100755 geoip/xt_geoip_fetch_maxmind

-- 
2.29.2

