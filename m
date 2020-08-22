Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55224E5DD
	for <lists+netfilter-devel@lfdr.de>; Sat, 22 Aug 2020 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgHVGWS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 22 Aug 2020 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgHVGWP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:22:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5344AC061755
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 23:22:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b17so3006981wru.2
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAW9m43a8ApNot/JnpRth6fPzV/22JSvUZ9w3wvTZfI=;
        b=okSyyXdj6OnnCdRn7mSPMe+wAbeCxXvCXJmSiIyZVWt6vpX60umKex47P7mP+ybkC1
         0D61FFyipp6ylkUzIT4Ic7hAHPcZvE6zfPIpwaik44ZZPdJyQsOYvDQDf2rFV2AiNFJr
         6SNGYW2W+3HKhi6+0JXonJiOLUMjbOk78XXZTYLGIaSfnBeOlfpWcavk06M38gwblYE8
         oJkscmVFk3KprvQyt1TtrU/4dJx9x/fru3L4FD/qfM8syq/fiyk8ZS2mFDH7R/fN+LJX
         W9VYT52K1OapXKEzegxIkFlh8o+6raBjVSJNegum2XkYJJNlBa4iuFD2n2e5ssL6cnC2
         cWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAW9m43a8ApNot/JnpRth6fPzV/22JSvUZ9w3wvTZfI=;
        b=FpE2VHsKFoUgHAUM3LmPPmHbLTSKEnxVob6EENf23NmN/F9dcWyYYGaiY4PnE04pXv
         QTrNk9z/YsKlU5IrfY8yrvxEWSzk44SYq9+hb82gtYZr8JaTQTqYLql7y4rF9M9jvvHO
         ZdFncwcXDq0hrhcnA6dPyqhiaEMMNOO/9k8uGLTMKOT/d+zuSTu+4Jm7Nd12kg6Ko8NU
         DSHcbMsvFvVY7JtXLxSjbeQJEspQLF4brjBs/V+SI6ubOkd2frjZ4A5UPk4xex5B9AVw
         4rXpJS8+hLzOIXpiGUYrSYbHxInojKIgme2PvWeLgutbdnxRCFrtXqk+JlfA0FFNyKWq
         vjDQ==
X-Gm-Message-State: AOAM531ewBVzklFfAhFJwJoNSTURvc31TUdWxxf3DrnY+4j143+gHBB6
        Rb+XW/EFc9nDUuJXmm4HsakQIe4IxOpW/A==
X-Google-Smtp-Source: ABdhPJy9YnLJLD+E/XDKtPlU/wdJsYTT/1fb2pUYZRa9bsrK80h2kMRz3pvyRhSCfv4SB6J9qAsQDQ==
X-Received: by 2002:adf:f007:: with SMTP id j7mr5357263wro.195.1598077332023;
        Fri, 21 Aug 2020 23:22:12 -0700 (PDT)
Received: from localhost.localdomain (BC2467A7.dsl.pool.telekom.hu. [188.36.103.167])
        by smtp.gmail.com with ESMTPSA id h5sm7016321wrt.31.2020.08.21.23.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 23:22:11 -0700 (PDT)
From:   Balazs Scheidler <bazsi77@gmail.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Balazs Scheidler <bazsi77@gmail.com>
Subject: [PATCH nftables 4/4] tests: allow tests to use a custom nft executable
Date:   Sat, 22 Aug 2020 08:22:03 +0200
Message-Id: <20200822062203.3617-5-bazsi77@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822062203.3617-1-bazsi77@gmail.com>
References: <20200822062203.3617-1-bazsi77@gmail.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Balazs Scheidler <bazsi77@gmail.com>
---
 tests/monitor/run-tests.sh | 2 +-
 tests/shell/run-tests.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index 943f8877..5233ba86 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -2,7 +2,7 @@
 
 # Configuration
 TESTDIR="./$(dirname $0)/testcases"
-SRC_NFT="$(dirname $0)/../../src/nft"
+SRC_NFT=${NFT:-../../src/nft}
 DIFF=$(which diff)
 
 msg_error() {
-- 
2.17.1

