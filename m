Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0232827A9C3
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Sep 2020 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1Ilj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Sep 2020 04:41:39 -0400
Received: from correo.us.es ([193.147.175.20]:33470 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1Ilj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:41:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3605ADA722
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Sep 2020 10:41:38 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23FCADA7B9
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Sep 2020 10:41:38 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 20ABFDA7B6; Mon, 28 Sep 2020 10:41:38 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DC4F5DA78B;
        Mon, 28 Sep 2020 10:41:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Sep 2020 10:41:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BDF2E42EE393;
        Mon, 28 Sep 2020 10:41:35 +0200 (CEST)
Date:   Mon, 28 Sep 2020 10:41:35 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Gopal Yadav <gopunop@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nftables] counter not working on kernel 5.6
Message-ID: <20200928084135.GA13120@salvia>
References: <CAAUOv8iOGYqi9YvvszTJ40b8bqAWT3dzhDbjdHHJTPQtnaseSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAUOv8iOGYqi9YvvszTJ40b8bqAWT3dzhDbjdHHJTPQtnaseSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:48:39PM +0530, Gopal Yadav wrote:
> Running the below commands:
> 
> nft add table inet dev
> nft add set inet dev ports_udp { type inet_service\; size 65536\;
> flags dynamic, timeout\; timeout 30d\; }
> nft add element inet dev ports_udp { 53 timeout 30d counter }
> nft list ruleset
> 
> Output:
> table inet dev {
> set ports_udp {
> type inet_service
> size 65536
> flags dynamic,timeout
> timeout 30d
> elements = { 53 expires 29d23h59m56s184ms }
> }
> }
> 
> Expected Output:
> table inet dev {
> set ports_udp {
> type inet_service
> size 65536
> flags dynamic,timeout
> timeout 30d
> elements = { 53 expires 29d23h59m56s184ms counter packets 0 bytes 0 }
> }
> }
> 
> Am I doing something wrong?

You need a 5.7 kernel.
