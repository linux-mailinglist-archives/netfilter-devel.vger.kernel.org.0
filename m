Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3286BB9E
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfGQLly (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 07:41:54 -0400
Received: from mail.us.es ([193.147.175.20]:37264 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfGQLly (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:41:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5E98EC1A66
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 13:41:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3512B1150B9
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 13:41:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1A0AB6DA95; Wed, 17 Jul 2019 13:41:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 27D711150CC;
        Wed, 17 Jul 2019 13:41:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 17 Jul 2019 13:41:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F42234265A2F;
        Wed, 17 Jul 2019 13:41:49 +0200 (CEST)
Date:   Wed, 17 Jul 2019 13:41:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] tests: py: add missing json outputs
Message-ID: <20190717114149.pgmcssw4aqgt3z5s@salvia>
References: <20190717104646.3387-1-ffmancera@riseup.net>
 <20190717104646.3387-2-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717104646.3387-2-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

also applied, thanks.
