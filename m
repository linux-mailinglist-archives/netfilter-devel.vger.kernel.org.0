Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DA261FF8
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Sep 2020 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIHUIf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Sep 2020 16:08:35 -0400
Received: from correo.us.es ([193.147.175.20]:35914 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgIHPTQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:19:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2E2511F0CE6
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 16:53:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1F00BDA722
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 16:53:07 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 14989DA730; Tue,  8 Sep 2020 16:53:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 02CB6DA722;
        Tue,  8 Sep 2020 16:53:05 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Sep 2020 16:53:05 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D53304301DE1;
        Tue,  8 Sep 2020 16:53:04 +0200 (CEST)
Date:   Tue, 8 Sep 2020 16:53:04 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 3/3] src: add comment support for objects
Message-ID: <20200908145304.GB12366@salvia>
References: <20200902091241.1379-1-guigom@riseup.net>
 <20200902091241.1379-4-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902091241.1379-4-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:12:41AM +0200, Jose M. Guisado Gomez wrote:
> Enables specifying an optional comment when declaring named objects. The
> comment is to be specified inside the object's block ({} block)
> 
> Relies on libnftnl exporting nftnl_obj_get_data and kernel space support
> to store the comments.
> 
> For consistency, this patch makes the comment be printed first when
> listing objects.
> 
> Adds a testcase importing all commented named objects except for secmark,
> although it's supported.
> 
> Example: Adding a quota with a comment
> 
> > add table inet filter
> > nft add quota inet filter q { over 1200 bytes \; comment "test_comment"\; }
> > list ruleset
> 
> table inet filter {
> 	quota q {
> 		comment "test_comment"
> 		over 1200 bytes
> 	}
> }

Also applied, thanks.
