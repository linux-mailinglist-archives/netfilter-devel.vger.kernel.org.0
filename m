Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA70A146B55
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jan 2020 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWOad (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jan 2020 09:30:33 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:39868 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWOad (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:30:33 -0500
Received: from localhost ([::1]:52956 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iudV9-0000mM-Ei; Thu, 23 Jan 2020 15:30:31 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 0/4] Covscan-induced review of ei_insert()
Date:   Thu, 23 Jan 2020 15:30:45 +0100
Message-Id: <20200123143049.13888-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

False covscan report led to closer investigation ei_insert() which
identified dead code and some opportunities for improvement due to the
fact that the only caller sorts the new intervals prior to calling said
function.

Note that if we at some point want to support merging of new and old set
elements, we will probably have to revert these patches since we can't
be sure anymore that there aren't any items with bigger values in the
set already.

Phil Sutter (4):
  segtree: Drop needless insertion in ei_insert()
  segtree: Drop dead code in ei_insert()
  segtree: Simplify overlap case in ei_insert()
  segtree: Refactor ei_insert()

 src/segtree.c | 101 +++++++++++++-------------------------------------
 1 file changed, 25 insertions(+), 76 deletions(-)

-- 
2.24.1

