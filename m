Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6140412F829
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jan 2020 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgACMZp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Jan 2020 07:25:45 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55594 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgACMZp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:25:45 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1inM1N-0005UE-86; Fri, 03 Jan 2020 13:25:41 +0100
Date:   Fri, 3 Jan 2020 13:25:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: checksum.c: remove redundant
 0xFFFF mask of uint16_t
Message-ID: <20200103122541.GM795@breakpoint.cc>
References: <20191230113345.olr3yifqqmytv3ce@salvia>
 <20191231010607.14313-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231010607.14313-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:

Applied.
