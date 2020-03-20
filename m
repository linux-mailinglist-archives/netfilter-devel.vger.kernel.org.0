Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CD18CE0B
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2020 13:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCTMyt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Mar 2020 08:54:49 -0400
Received: from correo.us.es ([193.147.175.20]:49600 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCTMys (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:54:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5177AF2DFC
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:54:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 439C3DA3AA
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:54:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 391ACDA3A9; Fri, 20 Mar 2020 13:54:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        PDS_TONAME_EQ_TOLOCAL_SHORT,SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D277DA72F;
        Fri, 20 Mar 2020 13:54:13 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Mar 2020 13:54:13 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3E09842EE38F;
        Fri, 20 Mar 2020 13:54:13 +0100 (CET)
Date:   Fri, 20 Mar 2020 13:54:44 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu <wenxu@ucloud.cn>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_flow_table_offload: fix kernel
 NULL pointer dereference in nf_flow_table_indr_block_cb
Message-ID: <20200320125444.lo4xieofbqyobsqb@salvia>
References: <1584528755-7969-1-git-send-email-wenxu@ucloud.cn>
 <ac599530-96aa-f562-87fb-3b5e24b7cb9e@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac599530-96aa-f562-87fb-3b5e24b7cb9e@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 20, 2020 at 08:42:37PM +0800, wenxu wrote:
> Hi Pablo,
> 
> 
> How about this bugfix?�� I see the status of this patch is accepted.
> 
> But it didn't apply to the master?

My mistake: back to "Under review" state.
