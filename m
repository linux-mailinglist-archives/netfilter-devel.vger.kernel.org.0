Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2575717E141
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2020 14:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgCINcy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Mar 2020 09:32:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgCINcx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:32:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-65yXE2xrOs6CdHSM1qwcvw-1; Mon, 09 Mar 2020 09:32:50 -0400
X-MC-Unique: 65yXE2xrOs6CdHSM1qwcvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17135184C804;
        Mon,  9 Mar 2020 13:32:49 +0000 (UTC)
Received: from egarver (ovpn-122-4.rdu2.redhat.com [10.10.122.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC3D1001DDE;
        Mon,  9 Mar 2020 13:32:47 +0000 (UTC)
Date:   Mon, 9 Mar 2020 09:32:46 -0400
From:   Eric Garver <eric@garver.life>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 1/2] parser_json: Support ranges in concat
 expressions
Message-ID: <20200309133246.tgjrnpigsbijwjim@egarver>
Mail-Followup-To: Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200307022633.6181-1-phil@nwl.cc>
MIME-Version: 1.0
In-Reply-To: <20200307022633.6181-1-phil@nwl.cc>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: garver.life
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Mar 07, 2020 at 03:26:32AM +0100, Phil Sutter wrote:
> Duplicate commit 8ac2f3b2fca38's changes to bison parser into JSON
> parser by introducing a new context flag signalling we're parsing
> concatenated expressions.
> 
> Fixes: 8ac2f3b2fca38 ("src: Add support for concatenated set ranges")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Changes since v1:
> - Fix accidental reject of concat expressions on LHS.
> ---

Thanks Phil. This passes all my tests and the patch looks good.

Acked-by: Eric Garver <eric@garver.life>

