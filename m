Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B36F116
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfGUARz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 20:17:55 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48890 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfGUARy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 20:17:54 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hozY1-0001iR-Qu; Sun, 21 Jul 2019 02:17:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 0/3] fix crash bug during rule restore
Date:   Sun, 21 Jul 2019 02:14:04 +0200
Message-Id: <20190721001406.23785-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

https://bugzilla.netfilter.org/show_bug.cgi?id=1351 

nft -f <<EOF
flush ruleset       

table inet filter {
}
table inet filter {
      chain test {
        counter
    }
}
EOF

segfaults during error reporting.
First patch makes error handling more robust.
Second patch passes the right handle -- with above ruleset this
highlights "chain test" in the resulting error message.

Last patch skips rule cache updates for invalid op to restore
the 0.9.0 behaviour.



