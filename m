Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC352D29E6
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Dec 2020 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgLHLo2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Dec 2020 06:44:28 -0500
Received: from correo.us.es ([193.147.175.20]:40822 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgLHLo2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:44:28 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8783FDA722
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 12:43:38 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 78DF51150A4
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 12:43:38 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6E59B1150A3; Tue,  8 Dec 2020 12:43:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 57233DA704;
        Tue,  8 Dec 2020 12:43:36 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Dec 2020 12:43:36 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 395234265A5A;
        Tue,  8 Dec 2020 12:43:36 +0100 (CET)
Date:   Tue, 8 Dec 2020 12:43:44 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 1/2] monitor: add assignment check for json_echo
Message-ID: <20201208114344.GA25623@salvia>
References: <20201206101233.641-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201206101233.641-1-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Dec 06, 2020 at 11:12:33AM +0100, Jose M. Guisado Gomez wrote:
> When --echo and --json is specified and native syntax is read, only the
> last instruction is printed. This happens because the reference to the
> json_echo is reassigned each time netlink_echo_callback is executed for
> an instruction to be echoed.
> 
> Add an assignment check for json_echo to avoid reassigning it.

Applied, thanks.
