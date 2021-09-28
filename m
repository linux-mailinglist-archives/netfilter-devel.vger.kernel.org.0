Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94741AD49
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Sep 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhI1Kvx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Sep 2021 06:51:53 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57176 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbhI1Kvx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:51:53 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 29C8763595;
        Tue, 28 Sep 2021 12:48:49 +0200 (CEST)
Date:   Tue, 28 Sep 2021 12:50:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_log 1/2] utils: nfulnl_test: Agree with man
 pages
Message-ID: <YVLzYO7SNAdljzSg@salvia>
References: <20210921085315.4340-1-duncan_roe@optusnet.com.au>
 <20210921085315.4340-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921085315.4340-2-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:53:14PM +1000, Duncan Roe wrote:
> Use the same variable name as the man pages / html for functions in the Parsing
> module (e.g. nflog_get_msg_packet_hdr(nfad)).

Applied, thanks.
