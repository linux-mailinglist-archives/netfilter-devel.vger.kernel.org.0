Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADB174674
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 Feb 2020 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgB2L1f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 Feb 2020 06:27:35 -0500
Received: from kadath.azazel.net ([81.187.231.250]:48660 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgB2L1e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 Feb 2020 06:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W81eVnK73t4uN0Ydv7WjeZc3XyZkl6OzaklliBBV7Dk=; b=FxZCxB/q4xzfVtft8JQ8pa/00w
        gmcRbhrt9JH/WQLDGPfF6pWmM+QoGc8Byo29Cy2aN2y5HUP1fFiNKPrO/XfZR1KsHQb49qDplVaWh
        i9TOs/HnhfqLWFgpOrMJV1MKVKKI30//3mWA1FD4eQJ856Z1IwDxWljBlyNP8LVC1q0nxxrMFRdgn
        BRXP0l2NV3KdwWbCCLs0ZrTjsP10BgK/laSFrWozKVrvEVqnLIY80XkM61u+Y/yM5bpYalBW6+0O/
        fY8f+lgqDqitUfN9Fqvf/Wgy2EmoN5A2i9v5OhSCMLxC93UxESOFfymPuTdgxbGyGQonI1lwg+YrQ
        CeuJxHYA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j80HL-0003Wm-Eg; Sat, 29 Feb 2020 11:27:31 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 00/18] Support for boolean binops with variable RHS operands.
Date:   Sat, 29 Feb 2020 11:27:13 +0000
Message-Id: <20200229112731.796417-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I initially held this patch-set back in anticipation of having to make
changes based on feed-back on the related libnftnl and kernel sets, but
it occurs to me that it provides extra context for those, so here it is.

Kernel support for passing mask and xor values for bitwise boolean
operations via registers allows us to support boolean binop's with
variable RHS operands: XOR expressions pass the xor value in a register;
AND expressions pass the mask value in a register; OR expressions pass
both mask and xor values in registers.

NB, OR expressions are converted to `(a & (b ^ 1)) ^ b` during
linearization (in patch 9), because it makes both linearization and
delinearization a lot simpler.  However, it involves rearranging and
allocating expressions after the evaluation phase.  Since nothing else
does this, AFAICS, I'm not sure whether it's the right thing to do.

The patch-set comprises four parts:

   1 -  7: some tidying and bug-fixes;
   8 - 10: support for variable RHS operands;
  11 - 15: updates to linearization and delinearization of payload
           expressions to work correctly with variable RHS operands;
  16 - 18: some new shell and Python test-cases.	   

Jeremy Sowden (18):
  evaluate: add separate variables for lshift and xor binops.
  evaluate: simplify calculation of payload size.
  evaluate: don't evaluate payloads twice.
  evaluate: convert the byte-order of payload statement arguments.
  evaluate: no need to swap byte-order for values of fewer than 16 bits.
  netlink_delinearize: set shift RHS byte-order.
  src: fix leaks.
  include: update nf_tables.h.
  src: support (de)linearization of bitwise op's with variable right
    operands.
  evaluate: allow boolean binop expressions with variable righthand
    arguments.
  netlink_linearize: round binop bitmask length up.
  netlink_delinearize: fix typo.
  netlink_delinearize: refactor stmt_payload_binop_postprocess.
  netlink_delinearize: add support for processing variable payload
    statement arguments.
  netlink_delinearize: add postprocessing for payload binops.
  tests: shell: remove stray debug flag.
  tests: shell: add variable binop RHS tests.
  tests: py: add variable binop RHS tests.

 include/expression.h                          |   1 +
 include/linux/netfilter/nf_tables.h           |   4 +
 src/evaluate.c                                |  75 ++--
 src/netlink_delinearize.c                     | 370 +++++++++++++-----
 src/netlink_linearize.c                       |  97 ++++-
 tests/py/any/ct.t                             |   1 +
 tests/py/any/ct.t.json                        |  37 ++
 tests/py/any/ct.t.payload                     |  33 ++
 tests/py/any/meta.t.payload                   |   4 -
 tests/py/inet/tcp.t                           |   2 +
 tests/py/inet/tcp.t.json                      |  46 ++-
 tests/py/inet/tcp.t.payload                   |  68 ++++
 tests/py/ip/ip.t                              |   3 +
 tests/py/ip/ip.t.json                         |  66 ++++
 tests/py/ip/ip.t.payload                      |  26 ++
 tests/py/ip/ip.t.payload.bridge               |  30 ++
 tests/py/ip/ip.t.payload.inet                 |  30 ++
 tests/py/ip/ip.t.payload.netdev               |  30 ++
 tests/shell/testcases/chains/0040mark_shift_0 |   2 +-
 tests/shell/testcases/chains/0040mark_shift_2 |  11 +
 .../testcases/chains/0041payload_variable_0   |  11 +
 .../testcases/chains/0041payload_variable_1   |  11 +
 .../testcases/chains/0041payload_variable_2   |  11 +
 .../testcases/chains/0041payload_variable_3   |  11 +
 .../chains/dumps/0040mark_shift_2.nft         |   6 +
 .../chains/dumps/0041payload_variable_0.nft   |   6 +
 .../chains/dumps/0041payload_variable_1.nft   |   6 +
 .../chains/dumps/0041payload_variable_2.nft   |   6 +
 .../chains/dumps/0041payload_variable_3.nft   |   6 +
 29 files changed, 873 insertions(+), 137 deletions(-)
 create mode 100755 tests/shell/testcases/chains/0040mark_shift_2
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_0
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_1
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_2
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_3
 create mode 100644 tests/shell/testcases/chains/dumps/0040mark_shift_2.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_0.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_1.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_2.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_3.nft

-- 
2.25.0

