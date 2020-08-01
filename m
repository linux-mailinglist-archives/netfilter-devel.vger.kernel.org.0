Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9C23546F
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Aug 2020 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHAVif (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Aug 2020 17:38:35 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49384 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHAVif (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Aug 2020 17:38:35 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BJyFR0X4KzFf0n
        for <netfilter-devel@vger.kernel.org>; Sat,  1 Aug 2020 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596317915; bh=cRcGNdg6bAcpHbNpFY5/TFPcbsUJ2qI7XRB3Vsl4t1c=;
        h=From:To:Subject:Date:From;
        b=CaKbQpsYPvHjgrUh/RbVmqpuUMVss7caEKkEUTySjXEwv4ULeD1ky2IO4LseeYORH
         YYgsn66FN2z1vDZHtyeGIWvAM2XyIPRzg7R7qLVkEdb6lfdeyORveR0QMtW+9VQvph
         1IDuPUvooNJcvtfx//ojszzqh9/A6mRqT6chUcnI=
X-Riseup-User-ID: 0E3D47C13AF59F27BC40B14F660E9F272F9BE34D15171EEFD08032B72DA472F4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BJyFQ2rmWz8tgT
        for <netfilter-devel@vger.kernel.org>; Sat,  1 Aug 2020 14:38:34 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] src: fix obj list output when reset command
Date:   Sat,  1 Aug 2020 23:30:10 +0200
Message-Id: <20200801213009.59650-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch enables json output when doing a reset command.

Previously do_list_obj was called at the end of do_command_reset to
list the named object affected by the reset, this function
is for nft output only.

Listing affected objects using do_command_list ensures
output flags will be honored.

Eg: For a ruleset like

table inet x {
	counter user123 {
		packets 12 bytes 1433
	}

	counter user321 {
		packets 0 bytes 0
	}

	quota user123 {
		over 2000 bytes
	}

	quota user124 {
		over 2000 bytes
	}

	set y {
		type ipv4_addr
	}

	...
}

# nft --json reset counters | python -m json.tool
{
    "nftables": [
        {
            "metainfo": {
                "json_schema_version": 1,
                "release_name": "Capital Idea #2",
                "version": "0.9.6"
            }
        },
        {
            "counter": {
                "bytes": 0,
                "family": "inet",
                "handle": 3,
                "name": "user321",
                "packets": 0,
                "table": "x"
            }
        },
        {
            "counter": {
                "bytes": 1433,
                "family": "inet",
                "handle": 2,
                "name": "user123",
                "packets": 12,
                "table": "x"
            }
        }
    ]
}


Fixes: https://bugzilla.netfilter.org/show_bug.cgi?id=1336

Signed-off-by: Jose M. Guisado Gomez <guigom@riseup.net>
---
 src/rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index fed9e123..6335aa21 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -2682,7 +2682,7 @@ static int do_command_reset(struct netlink_ctx *ctx, struct cmd *cmd)
 	if (ret < 0)
 		return ret;
 
-	return do_list_obj(ctx, cmd, type);
+	return do_command_list(ctx, cmd);
 }
 
 static int do_command_flush(struct netlink_ctx *ctx, struct cmd *cmd)
-- 
2.27.0

