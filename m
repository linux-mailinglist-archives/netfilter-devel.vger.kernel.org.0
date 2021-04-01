Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE1351BC6
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDASLA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbhDASIs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:08:48 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8AEC08ECBD
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Apr 2021 07:08:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lRy0C-0001XB-83; Thu, 01 Apr 2021 16:08:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/4] Add support for 8021.AD frame matching
Date:   Thu,  1 Apr 2021 16:08:42 +0200
Message-Id: <20210401140846.24452-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This allows to match vlan frames with 8021.AD ("QinQ") type.

Plan 'vlan id 1' will imply 8021Q, just as before, so explicit
type specification is needed.
This in turn makes it necessary to extend dependency removal so that
it will not auto-remove 8021ad check.

Add test case to make sure depdenencies are generated correctly,
this includes checks for 'vlan id 2' in a 'vlan id 1' vlan tag stack.

Florian Westphal (4):
  src: vlan: allow matching vlan id insider 802.1ad frame
  proto: add 8021ad as mnemonic for IEEE 802.1AD (0x88a8) ether type
  payload: be careful on vlan dependency removal
  tests: add 8021.AD vlan test cases

 src/payload.c                         |  29 ++++-
 src/proto.c                           |   4 +
 src/scanner.l                         |   1 +
 tests/py/bridge/vlan.t                |   5 +
 tests/py/bridge/vlan.t.json           | 176 ++++++++++++++++++++++++++
 tests/py/bridge/vlan.t.json.output    | 173 +++++++++++++++++++++++++
 tests/py/bridge/vlan.t.payload        |  45 +++++++
 tests/py/bridge/vlan.t.payload.netdev |  51 ++++++++
 8 files changed, 481 insertions(+), 3 deletions(-)

-- 
2.26.3

