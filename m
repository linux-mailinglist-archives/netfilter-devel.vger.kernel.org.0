Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA910DE58
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Nov 2019 18:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3RCV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Nov 2019 12:02:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:52152 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RCV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Nov 2019 12:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d+ZTK3PNVqcSsySVLbrJzjMK3lQMZyLkcIAqhYZK5aQ=; b=k2b8LKO+jAUivQpU/dsIJl3rD/
        bQNPmHbSV5HDaWB/SEF9fJfw2w7mS1f2oHILgk7phAucL/weSxCq6zhxZiKKZoxQXEir7pM3ah95Q
        7E5zHU9OkJpjG302nyBsFS9Fy96zhpNGW5Sp1q9fr7CW/EhpRHATaQz4QQPlFOexukGJ2ARGw6dGR
        Be7RegZzKcYEyOz2Yd3RyKK8GY8KPNP3CcGMElZ4z5p09mkpAfw7OlZjG7ecKKfAn87sceaAhe2eD
        IQJlAUedcotvFmRpwb2i9+rPNVQbz/30nXv+ufF+nYS9+A8+733ApDTqJERh3kun6eiTZkOljSwEz
        AVc+93rA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1ib68R-0001qd-Sp; Sat, 30 Nov 2019 17:02:19 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        "Thomas B . Clark" <kernel@clark.bz>
Subject: [PATCH xtables-addons 0/3] xt_geoip: ipv6 fixes
Date:   Sat, 30 Nov 2019 17:02:15 +0000
Message-Id: <20191130170219.368867-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org>
References: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Clark reported that geoip matching didn't work for ipv6.  This
series fixes that and a couple of other minor issues.

Jeremy Sowden (3):
  configure: update max. supported kernel version.
  xt_geoip: white-space fixes.
  xt_geoip: fix in6_addr little-endian byte-swapping.

 configure.ac             |  2 +-
 extensions/libxt_geoip.c | 28 ++++++++--------------------
 extensions/xt_geoip.c    |  6 +++---
 3 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.24.0

