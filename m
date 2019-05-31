Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8430FFA
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEaOR5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 10:17:57 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45540 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaOR5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 10:17:57 -0400
Received: from localhost ([::1]:58630 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hWiM0-0000Wl-Cl; Fri, 31 May 2019 16:17:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/2] Fix and simplify mnl_batch_talk()
Date:   Fri, 31 May 2019 16:17:41 +0200
Message-Id: <20190531141743.15049-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

As requested, here's the mnl_batch_talk() fix extracted from previous
series. To make things more clear, I've split this into a very minimal
FD_SET/select reordering fix and a follow-up simplifying the code a bit.

Feel free to fold into your own series and/or dismiss second patch at
your own convenience. :)

Phil Sutter (2):
  mnl: Initialize fd_set before select(), not after
  mnl: Simplify mnl_batch_talk()

 src/mnl.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.21.0

