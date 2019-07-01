Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40181337A
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2019 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfECSEK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 May 2019 14:04:10 -0400
Received: from mail.us.es ([193.147.175.20]:60042 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfECSEK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 May 2019 14:04:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CDEEC11EF41
        for <netfilter-devel@vger.kernel.org>; Fri,  3 May 2019 20:04:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BCC97DA709
        for <netfilter-devel@vger.kernel.org>; Fri,  3 May 2019 20:04:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B225FDA708; Fri,  3 May 2019 20:04:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BA787DA702;
        Fri,  3 May 2019 20:04:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 03 May 2019 20:04:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 968374265A31;
        Fri,  3 May 2019 20:04:06 +0200 (CEST)
Date:   Fri, 3 May 2019 20:04:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] use UDATA defines from libnftnl
Message-ID: <20190503180406.uteyesoecy3hqcsq@salvia>
References: <20190425125654.15125-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425125654.15125-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:56:54PM +0200, Phil Sutter wrote:
> Userdata attribute names have been added to libnftnl, use them instead
> of the local copy.
> 
> While being at it, rename udata_get_comment() in netlink_delinearize.c
> and the callback it uses since the function is specific to rules. Also
> integrate the existence check for NFTNL_RULE_USERDATA into it along with
> the call to nftnl_rule_get_data().

Applied, thanks Phil.
