Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA13401975
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbhIFKHJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 06:07:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39322 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhIFKHJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:07:09 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id A41DB6001C;
        Mon,  6 Sep 2021 12:04:58 +0200 (CEST)
Date:   Mon, 6 Sep 2021 12:05:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] build: doc: Fix rendering of verbatim
 '\n"' in man pages
Message-ID: <20210906100559.GA12817@salvia>
References: <20210905024554.29795-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210905024554.29795-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Sep 05, 2021 at 12:45:54PM +1000, Duncan Roe wrote:
> Without this patch, '\n"' rendered as '0' in e.g. man nfq_create_queue

Applied, thanks.
