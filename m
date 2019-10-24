Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1390E2D34
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408867AbfJXJZp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 05:25:45 -0400
Received: from correo.us.es ([193.147.175.20]:58292 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408862AbfJXJZo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:25:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8D54DEBAD3
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:25:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7F17BB7FF6
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:25:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 74B54FB362; Thu, 24 Oct 2019 11:25:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7B63DA7B6;
        Thu, 24 Oct 2019 11:25:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Oct 2019 11:25:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9657642EE38E;
        Thu, 24 Oct 2019 11:25:37 +0200 (CEST)
Date:   Thu, 24 Oct 2019 11:25:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables_offload: Fix unbind devices
 when subsequent device bind failed
Message-ID: <20191024092539.bzvbob3nk4sspawf@salvia>
References: <1571889322-26547-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571889322-26547-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:55:22AM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> In the nft_flow_block_chain some devices bind success, but the subsequent
> device failed. It should unbind the successful devices.

Thank you for you patch, although I decided to follow a different path:

https://patchwork.ozlabs.org/patch/1182733/
