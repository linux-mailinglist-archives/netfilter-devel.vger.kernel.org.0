Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EDA11E771
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Dec 2019 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfLMQDw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Dec 2019 11:03:52 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:40330 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727932AbfLMQDv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:03:51 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ifnPy-0004Cj-0j; Fri, 13 Dec 2019 17:03:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 00/10] add typeof keyword
Date:   Fri, 13 Dec 2019 17:03:34 +0100
Message-Id: <20191213160345.30057-1-fw@strlen.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch series adds the typeof keyword.

The only dependency is a small change to libnftnl to add two new
UDATA_SET_TYPEOF enum values.

named set can be configured as follows:

set os {
   typeof osf name
   elements = { "Linux", "Windows" }
}

or

nft add set ip filter allowed "{ typeof ip daddr  . tcp dport; }"

... which is the same as the "old" 'type ipv4_addr . inet_service".

The type is stored in the kernel via the udata set infrastructure,
on listing -- if a udata type is present -- nft will validate that this
type matches the set key length.

Note that while 'typeof' can be used with concatenations, they
only work as aliases for known types -- its currently not possible
to use integer/string types via the 'typeof' keyword.

Doing so requires a bit more work to dissect the correct key
geometry on netlink dumps, we can also not fallback in this case,
i.e. if the typeof udata is not there/invalid, we would be
unable to reconstruct the needed subkey size information.

Florian Westphal (10):
      parser: add a helper for concat expression handling
      libnftnl: split nft_ctx_new/free
      src: store expr, not dtype to track data in sets
      src: parser: add syntax to provide size of variable-sized data types
      src: add "typeof" print support
      mnl: round up the map data size too
      src: netlink: remove assertion
      evaluate: print a hint about 'type,width' syntax on 0 keylen
      doc: mention 'typeof' as alternative to 'type' keyword
      tests: add typeof test cases

Pablo Neira Ayuso (1):
      parser: add typeof keyword for declarations

 23 files changed, 582 insertions(+), 154 deletions(-)
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_maps_0.nft
 create mode 100755 tests/shell/testcases/maps/typeof_maps_0
 create mode 100644 tests/shell/testcases/sets/dumps/typeof_sets_0.nft
 create mode 100755 tests/shell/testcases/sets/typeof_sets_0


