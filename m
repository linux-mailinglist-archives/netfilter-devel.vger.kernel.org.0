Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5961370E3E7
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 May 2023 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEWRKS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 May 2023 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEWRKR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 May 2023 13:10:17 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825F90;
        Tue, 23 May 2023 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1684861816; x=1716397816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r4qQMfaI1qjgbzjXoDIxbJ+UkErC3soNDbr3LWqBikA=;
  b=OslMN7z9LMJbLLsTKLqd3nnL0JzTLJVTtj66Mn9gUVb99fm2bh/7M913
   X5zUSYIARXcaTifmMc6FUyEJ8SiprZDB9DxIBDYsOpS5h37SitdnGd+PA
   m2xFWCOP/M9n20WkcD2HwF68uYWxWLIQ0Yl4tvXavBMBXNU9Upe41JM7l
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,186,1681171200"; 
   d="scan'208";a="1133087791"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 17:09:56 +0000
Received: from EX19D011EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id CB1D240D4D;
        Tue, 23 May 2023 17:09:55 +0000 (UTC)
Received: from EX19D026EUB004.ant.amazon.com (10.252.61.64) by
 EX19D011EUA001.ant.amazon.com (10.252.50.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 17:09:51 +0000
Received: from uc3ecf78c6baf56.ant.amazon.com (10.187.170.24) by
 EX19D026EUB004.ant.amazon.com (10.252.61.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 17:09:48 +0000
From:   Andrew Paniakin <apanyaki@amazon.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
CC:     Andrew Paniakin <apanyaki@amazon.com>, <stable@vger.kernel.org>,
        <luizcap@amazon.com>, <benh@amazon.com>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4.14] netfilter: nf_tables: fix register ordering
Date:   Tue, 23 May 2023 10:09:35 -0700
Message-ID: <20230523170935.2288354-1-apanyaki@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZGx9JsCjvoDNRTBy@calendula>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.24]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D026EUB004.ant.amazon.com (10.252.61.64)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, 23 May 2023 10:45:26 +0200 Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Mon, May 22, 2023 at 07:59:41PM -0700, Andrew Paniakin wrote:
> > From: Florian Westphal <fw@strlen.de>
> >
> > commit d209df3e7f7002d9099fdb0f6df0f972b4386a63 upstream
> >
> 
> I have to send pending batch of updates for -stable 4.14.
> 
> I take this patch and I will pass it on -stable maintainers.
> 
> Thanks.
> 
Sure, thanks for the help!
