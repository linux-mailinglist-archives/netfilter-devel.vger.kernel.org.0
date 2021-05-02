Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67818370F64
	for <lists+netfilter-devel@lfdr.de>; Sun,  2 May 2021 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhEBVqh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 2 May 2021 17:46:37 -0400
Received: from mail.netfilter.org ([217.70.188.207]:38946 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhEBVqh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 2 May 2021 17:46:37 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6248A63089;
        Sun,  2 May 2021 23:45:03 +0200 (CEST)
Date:   Sun, 2 May 2021 23:45:42 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan.roe2@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, jengelh@inai.de,
        duncan_roe@optusnet.com.au
Subject: Re: [PATCH libnetfilter_queue v2] build: doc: `make distcheck`
 passes with doxygen enabled
Message-ID: <20210502214542.GA12067@salvia>
References: <s6o3s8n-8486-r468-728s-4384736oqq@vanv.qr>
 <20210422093544.5460-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210422093544.5460-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:35:44PM +1000, Duncan Roe wrote:
> The main fix is to move fixmanpages.sh to inside doxygen/Makefile.am.
> 
> This means that in future, developers need to update doxygen/Makefile.am
> when they add new functions and source files, since fixmanpages.sh is deleted.

Applied.
