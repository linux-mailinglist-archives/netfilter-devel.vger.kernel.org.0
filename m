Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746CA3F5C2A
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Aug 2021 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhHXKcr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Aug 2021 06:32:47 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43092 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbhHXKce (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:32:34 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7DB4860254;
        Tue, 24 Aug 2021 12:30:01 +0200 (CEST)
Date:   Tue, 24 Aug 2021 12:30:52 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v4 4/4] build: doc: split off shell
 script from within doxygen/Makefile.am
Message-ID: <20210824103052.GC30322@salvia>
References: <20210822041442.8394-1-duncan_roe@optusnet.com.au>
 <20210822041442.8394-4-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210822041442.8394-4-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 22, 2021 at 02:14:42PM +1000, Duncan Roe wrote:
> This time, Makefile obeys the script via its absolute source pathname rather
> than trying to force a copy into the build dir as we did previously.

Could you make this in first place? As coming 1/x coming in this
series.

Thanks.
