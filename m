Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1607331082
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCHOM1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 09:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCHOL4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:56 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37567C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 06:11:56 -0800 (PST)
Received: from localhost ([::1]:53502 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJGby-0003SA-Q2; Mon, 08 Mar 2021 15:11:54 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 0/5] A few cosmetic changes
Date:   Mon,  8 Mar 2021 15:11:14 +0100
Message-Id: <20210308141119.17809-1-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is fallout from the sheer endless mini-project of fixing byteorder
in debug output.

This series deals with minor nuisances I found:

* Dead code in socket, tunnel and xfrm expressions
* Trailing spaces in debug output for rules
* Ugly indenting due to long function
  nftnl_data_reg_value_snprintf_default()

Phil Sutter (5):
  expr/socket: Kill dead code
  expr/tunnel: Kill dead code
  expr/xfrm: Kill dead code
  rule: Avoid printing trailing spaces
  expr: data_reg: Reduce indenting level a bit

 src/expr/data_reg.c | 31 ++++++++-----------------------
 src/expr/socket.c   | 13 -------------
 src/expr/tunnel.c   | 13 -------------
 src/expr/xfrm.c     | 28 ----------------------------
 src/rule.c          | 27 ++++++++++++++++++---------
 5 files changed, 26 insertions(+), 86 deletions(-)

-- 
2.30.1

