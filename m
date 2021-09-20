Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33D4113BB
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Sep 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhITLrq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 07:47:46 -0400
Received: from mail.netfilter.org ([217.70.188.207]:37906 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhITLrp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:47:45 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id CA92363595;
        Mon, 20 Sep 2021 13:45:00 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:46:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_log] utils: nfulnl_test: Print meaningful
 error messages
Message-ID: <YUh0hbnjhzsuFI4O@salvia>
References: <20210908084835.17448-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908084835.17448-1-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 08, 2021 at 06:48:35PM +1000, Duncan Roe wrote:
> e.g. "Operation not supported" when run as non-root

Also applied, thanks.
