Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77E1D4FE1
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2020 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEOOEa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 May 2020 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOEa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 May 2020 10:04:30 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B52C061A0C
        for <netfilter-devel@vger.kernel.org>; Fri, 15 May 2020 07:04:29 -0700 (PDT)
Received: from localhost ([::1]:52354 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jZaw7-0006qn-Ng; Fri, 15 May 2020 16:04:26 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 0/2] Critical: Unbreak nfnl_osf tool
Date:   Fri, 15 May 2020 16:03:28 +0200
Message-Id: <20200515140330.13669-1-phil@nwl.cc>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No changes in patch 1, it is still the right fix for the problem and
restores original behaviour.

Patch 2 changed according to feedback:

- Elaborate on why there are duplicates in pf.os in the first place.

- Ignore ENOENT when deleting. Since the code ignores EEXIST when
  creating, reporting this was asymmetrical behaviour.

- Fix for ugly error message when user didn't specify '-f' option.

Phil Sutter (2):
  nfnl_osf: Fix broken conversion to nfnl_query()
  nfnl_osf: Improve error handling

 utils/nfnl_osf.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.26.2

