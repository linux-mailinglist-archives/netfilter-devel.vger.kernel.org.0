Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214229397C
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Oct 2020 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393390AbgJTK5s (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Oct 2020 06:57:48 -0400
Received: from correo.us.es ([193.147.175.20]:42262 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393400AbgJTK5s (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:57:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 386FFFFBC8
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Oct 2020 12:57:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23ECE115112
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Oct 2020 12:57:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1AEC7115110; Tue, 20 Oct 2020 12:57:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7C4B100A7F;
        Tue, 20 Oct 2020 12:57:08 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 20 Oct 2020 12:57:08 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7EC27411FD11;
        Tue, 20 Oct 2020 12:57:08 +0200 (CEST)
Date:   Tue, 20 Oct 2020 12:57:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     yang_y_yi@163.com
Cc:     netfilter-devel@vger.kernel.org, yangyi01@inspur.com
Subject: Re: [PATCH] conntrack: fix zone sync issue
Message-ID: <20201020105706.GA3877@salvia>
References: <20201019030422.396340-1-yang_y_yi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019030422.396340-1-yang_y_yi@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:04:22AM +0800, yang_y_yi@163.com wrote:
> From: Yi Yang <yangyi01@inspur.com>
> 
> In some use cases, zone is used to differentiate different
> conntrack state tables, so zone also should be synchronized
> if it is set.

Applied, thanks.
