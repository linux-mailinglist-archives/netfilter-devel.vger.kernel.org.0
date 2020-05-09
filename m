Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0925C1CC114
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 May 2020 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgEILwK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 May 2020 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgEILwK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 May 2020 07:52:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F04C061A0C
        for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2020 04:52:10 -0700 (PDT)
Received: from localhost ([::1]:37184 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jXO1Y-0005fY-P3; Sat, 09 May 2020 13:52:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/2] Critical: Unbreak nfnl_osf tool
Date:   Sat,  9 May 2020 13:51:58 +0200
Message-Id: <20200509115200.19480-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I managed to render nfnl_osf tool useless with my (obviously untested)
conversion to nfnl_query(). Unbreak it and also fix delete functionality
which was already broken before I started messing with it.

Phil Sutter (2):
  nfnl_osf: Fix broken conversion to nfnl_query()
  nfnl_osf: Improve error handling

 utils/nfnl_osf.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.25.1

