Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C59261FFF
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Sep 2020 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgIHUIj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Sep 2020 16:08:39 -0400
Received: from correo.us.es ([193.147.175.20]:35892 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgIHPTP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:19:15 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 892861F0CE5
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 16:52:56 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7B853DA78A
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 16:52:56 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 71002DA789; Tue,  8 Sep 2020 16:52:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6E931DA73F;
        Tue,  8 Sep 2020 16:52:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Sep 2020 16:52:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 506CF4301DE2;
        Tue,  8 Sep 2020 16:52:54 +0200 (CEST)
Date:   Tue, 8 Sep 2020 16:52:53 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnftnl 2/3] object: add userdata and comment support
Message-ID: <20200908145253.GA12366@salvia>
References: <20200902091241.1379-1-guigom@riseup.net>
 <20200902091241.1379-3-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902091241.1379-3-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:12:40AM +0200, Jose M. Guisado Gomez wrote:
> This patch adds NFTNL_OBJ_USERDATA to support userdata for objects.
> 
> Also adds NFTNL_UDATA_OBJ_COMMENT to support comments for objects,
> stored in userdata space.
> 
> Bumps libnftnl.map to 15 as nftnl_obj_get_data needs to be exported to
> enable getting object attributes/data.

Applied, thanks.
