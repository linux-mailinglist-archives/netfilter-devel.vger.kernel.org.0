Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1152EE18B5
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Oct 2019 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbfJWLU3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Oct 2019 07:20:29 -0400
Received: from correo.us.es ([193.147.175.20]:32984 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404770AbfJWLU3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:20:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CD760D165B
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 13:20:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BED26B7FF6
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 13:20:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B495CB7FF2; Wed, 23 Oct 2019 13:20:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B17FBB7FF9;
        Wed, 23 Oct 2019 13:20:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Oct 2019 13:20:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7D00541E4803;
        Wed, 23 Oct 2019 13:20:22 +0200 (CEST)
Date:   Wed, 23 Oct 2019 13:20:24 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Use ARRAY_SIZE() macro in nft_strerror()
Message-ID: <20191023112024.gd4dqe6qqv46hufe@salvia>
References: <20191018155114.7423-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018155114.7423-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 18, 2019 at 05:51:14PM +0200, Phil Sutter wrote:
> Variable 'table' is an array of type struct table_struct, so this is a
> classical use-case for ARRAY_SIZE() macro.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
