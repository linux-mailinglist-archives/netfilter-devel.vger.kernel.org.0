Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B41E83E8
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Oct 2019 10:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfJ2JLh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Oct 2019 05:11:37 -0400
Received: from correo.us.es ([193.147.175.20]:60178 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfJ2JLh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:11:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2754E303D07
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Oct 2019 10:11:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19143A7E1E
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Oct 2019 10:11:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 18564A7E19; Tue, 29 Oct 2019 10:11:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        PDS_TONAME_EQ_TOLOCAL_SHORT,SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3C5ACDA72F;
        Tue, 29 Oct 2019 10:11:30 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 29 Oct 2019 10:11:30 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1084041E4805;
        Tue, 29 Oct 2019 10:11:30 +0100 (CET)
Date:   Tue, 29 Oct 2019 10:11:32 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu <wenxu@ucloud.cn>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables_offload: support offload
 iif types meta offload
Message-ID: <20191029091132.leou3h35y2snu7gi@salvia>
References: <1571989584-940-1-git-send-email-wenxu@ucloud.cn>
 <20191028150518.ddqjqv6aamwv4uic@salvia>
 <8718c5b3-4c42-8dc7-35ed-59d8e7df6c38@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8718c5b3-4c42-8dc7-35ed-59d8e7df6c38@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 29, 2019 at 04:23:56PM +0800, wenxu wrote:
> So it is better to extend the flow_dissector_key_meta to support iiftype match?

This is what the patches that I'm just about to send are doing, yes.
