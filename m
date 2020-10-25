Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03C2981CB
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416211AbgJYNQI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416212AbgJYNQG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:16:06 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9680EC0613D2
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nehFOayPVG8vpj6TWGUIwnABCurylEc22NkBysTX/O0=; b=iUdqebLW1e+4eQR+s5T6fXGmps
        iNKmxgErMjjXovjkEZ/sIzjL4yamloAQAAe/8FmqC9J+fmiDAgfrFu0eP3M4HYw26S6Rp21HKz0Ik
        Mq7f28FMUr/LuwtN/aKLGtszGtYDvwen8z3TfNKPj0GB4yyQBJR8B2Hdy2dqPKYJHwIkKE8mWc3t4
        N6Ji0155PWtFoPrF0j/EUnI2Y1fTHsx/WLxb6r9JxW2+w2UFmY220BrZrbukOcunSrOXcUu7eUrFY
        0S9+u+XdnTa+dIKbwb1nKmgyGMry1L4/lHThvBKwXz0JBV/gf+Dzl1pzyeXg2a32PLMaq73zv3kjl
        oarADaRA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kWfsS-0001SE-31; Sun, 25 Oct 2020 13:16:04 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 00/13] pknlusr improvements
Date:   Sun, 25 Oct 2020 13:15:45 +0000
Message-Id: <20201025131559.920038-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since pknlusr is now installed, here are some improvements.  There's one
automake change related to the new man-page, a number of new patches
tidying up the source of pknlusr.c, before a new version of the patch to
remove the hard-coded group ID.  The last four patches do a bit of
tiding of the pknock kernel module.

Jeremy Sowden (13):
  pknock: pknlusr: ensure man-page is included by `make dist`.
  pknock: pknlusr: remove dest_addr and rename src_addr.
  pknock: pknlusr: tighten up variable scopes.
  pknock: pknlusr: tidy up initialization of local address.
  pknock: pknlusr: use NLMSG macros and proper types, rather than
    arithmetic on char pointers.
  pknock: pknlusr: use macro to define inet_ntop buffer size.
  pknock: pknlusr: don't treat recv return value of zero as an error.
  pknock: pknlusr: always close socket.
  pknock: pknlusr: fix hard-coded netlink multicast group ID.
  pknock: xt_pknock: use IS_ENABLED.
  pknock: xt_pknock: use kzalloc.
  pknock: xt_pknock: use pr_err.
  pknock: xt_pknock: remove DEBUG definition.

 extensions/pknock/Makefile.am |   2 +-
 extensions/pknock/pknlusr.c   | 120 ++++++++++++++++++++++------------
 extensions/pknock/xt_pknock.c |  27 +++-----
 extensions/pknock/xt_pknock.h |   2 -
 4 files changed, 88 insertions(+), 63 deletions(-)

-- 
2.28.0

