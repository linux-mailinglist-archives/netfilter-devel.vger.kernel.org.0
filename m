Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980D256589
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 Aug 2020 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgH2HEY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 Aug 2020 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgH2HEW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:04:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A08C061236
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 00:04:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s13so1071960wmh.4
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5NjOSHSUkrRcGbZa0mLW5SOkeT8H42V/t/fJ0yqb1Q=;
        b=W3uWp2lww5tLx1Kld9ndmxZZZruYgyr0X/D+S0Syfg1g+EyCDFuz3u0yhm4akb3VQY
         XF+GFdPYnETFDW9mxxToa+1kqvxnhHC/xQkVYoAxCPfl90hzxPLX5xF5urnKHH6n9hgX
         VDBW6kgr3mMylLx+8/XQa5es+HvsW32idsYAbcJ4IQKotgOaovhxLP3f2MWO7ZSGMlk3
         jFj5yl3mEoEK0l/Q6+miWFIQEtDo0IqJ4Vb2SIzWSenUlUcz5LhJq6mGpTg3xaDSerpv
         utLpfg73Z1GUIiwyn49HPqYn9VMa7thH2j9j04FeCuLG6f/XL93/t68MKvcCN+dYQHVt
         /LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5NjOSHSUkrRcGbZa0mLW5SOkeT8H42V/t/fJ0yqb1Q=;
        b=YNiquVNaj2le4CN1PzrnSspGyDE5L3RBESxrgOd9zajomwc3famXhfKYi2U9H5cvfb
         jl1T0nlfpwyH0Kg+wqB1ikYAZsHI6SgVvaR1OUy53/X7iFrYVPotZbFkUNwrACgVRl8r
         5KSKej+T8JqhpSkyG/2wEULR9Qp561mn8OtmTbozamIhEV/2d1nu/29GiXNwqARXi245
         OqIxKHQlHQb/3vUUJ1VMSu8YFhxlJcuhrXxwz8L8aT0PZioPFZMOeA5BonSBr3DbSnsN
         P9cQYgyP+yRo/f9KnhUi6yG2Db4KuFRwonAYI4CYcNyWTTlxamyhU6fTFffHc5zL0nia
         94Gg==
X-Gm-Message-State: AOAM532NF+wm5dffmdCryxJGGapm2D3vhBrRZ/lSvh2lLao42nkkp9hq
        eoa0Pz4cPrAf5qASGo8kUFmeNYVSoLYysg==
X-Google-Smtp-Source: ABdhPJxvFKe6JZyaHozgGa0P0PFGl7oD9gOE3WuP0y8pmBO/fvuGkO5f1M8Evl7ruxY3Z4gzYQ+dug==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr2047229wma.123.1598684659329;
        Sat, 29 Aug 2020 00:04:19 -0700 (PDT)
Received: from localhost.localdomain (94-21-174-118.pool.digikabel.hu. [94.21.174.118])
        by smtp.gmail.com with ESMTPSA id f2sm2489756wrj.54.2020.08.29.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 00:04:18 -0700 (PDT)
From:   Balazs Scheidler <bazsi77@gmail.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Balazs Scheidler <bazsi77@gmail.com>
Subject: [PATCH nftables v2 5/5] tests: allow tests/monitor to use a custom nft executable
Date:   Sat, 29 Aug 2020 09:04:05 +0200
Message-Id: <20200829070405.23636-6-bazsi77@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829070405.23636-1-bazsi77@gmail.com>
References: <20200829070405.23636-1-bazsi77@gmail.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Balazs Scheidler <bazsi77@gmail.com>
---
 tests/monitor/run-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/monitor/run-tests.sh b/tests/monitor/run-tests.sh
index ffb833a7..5a736fc6 100755
--- a/tests/monitor/run-tests.sh
+++ b/tests/monitor/run-tests.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 
 cd $(dirname $0)
-nft=../../src/nft
+nft=${NFT:-../../src/nft}
 debug=false
 test_json=false
 
-- 
2.17.1

