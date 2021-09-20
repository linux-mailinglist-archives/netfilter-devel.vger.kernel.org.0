Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241C64113C2
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Sep 2021 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhITLue (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 07:50:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:37924 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhITLuV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:50:21 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 918A963595;
        Mon, 20 Sep 2021 13:47:37 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:48:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_log] src: make nflog_open_nfnl() static
Message-ID: <YUh1IuIoB/Q5GOCO@salvia>
References: <20210913055749.24171-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913055749.24171-1-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 13, 2021 at 03:57:49PM +1000, Duncan Roe wrote:
> nflog_open_nfnl() is neither documented nor used outside the source file
> wherin it is defined.
> (ulogd doesn't use this function either).

I'm afraid someone might be using it, even if it was never documented.
