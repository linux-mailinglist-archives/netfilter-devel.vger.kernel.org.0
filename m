Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C878273688
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Sep 2020 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgIUXQH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Sep 2020 19:16:07 -0400
Received: from correo.us.es ([193.147.175.20]:53320 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUXQH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:16:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4DDF2117740
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 01:16:06 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3E7B8DA84A
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 01:16:06 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3D927DA855; Tue, 22 Sep 2020 01:16:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09665DA84A;
        Tue, 22 Sep 2020 01:16:04 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Sep 2020 01:16:04 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D582242EF4E0;
        Tue, 22 Sep 2020 01:16:03 +0200 (CEST)
Date:   Tue, 22 Sep 2020 01:16:03 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     igo95862 <igo95862@yandex.ru>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libmnl] doxygen: Fixed link to the git source tree on the
 website.
Message-ID: <20200921231603.GA6041@salvia>
References: <20200915020826.67909-1-igo95862@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915020826.67909-1-igo95862@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:08:26PM -0700, igo95862 wrote:
> Old link no longer worked.
> Also upgraded it to https.

Applied, thanks.
