Return-Path: <netfilter-devel+bounces-3-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6A7F5CD9
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF70228196A
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C4199D1;
	Thu, 23 Nov 2023 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD210F5
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Nov 2023 02:48:47 -0800 (PST)
Received: from [78.30.43.141] (port=43776 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1r67GF-00HCAy-Dh; Thu, 23 Nov 2023 11:48:45 +0100
Date: Thu, 23 Nov 2023 11:48:42 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Thomas Haller <thaller@redhat.com>
Cc: NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/1] tests/shell: accept name of dump files in place
 of test names
Message-ID: <ZV8uCk27rVe5ts9t@calendula>
References: <20231122182227.759051-1-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122182227.759051-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)

On Wed, Nov 22, 2023 at 07:22:25PM +0100, Thomas Haller wrote:
> diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
> index 3cde97b7ea17..c26142b7ff17 100755
> --- a/tests/shell/run-tests.sh
> +++ b/tests/shell/run-tests.sh
> @@ -431,6 +431,19 @@ for t in "${TESTSOLD[@]}" ; do
>  	elif [ -d "$t" ] ; then
>  		TESTS+=( $(find_tests "$t") )
>  	else
> +		if [ -f "$t" ] ; then
> +			# If the test name looks like a dumps file, autodetect
> +			# the correct test name. It's not useful to bother the
> +			# user with a failure in this case.
> +			rx="^(.*/)?dumps/([^/]+)\\.(nodump|nft|json-nft)$"
> +			if [[ "$t" =~ $rx ]] ; then
> +				t2="${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
> +				if [ -f "$t2" -a -x "$t2" ] ; then
> +					TESTS+=( "$t2" )
> +					continue
> +				fi
> +			fi
> +		fi

I think it is not worth, users of this infrastructure is very small.

So let's keep back this usability feature for tests/shell.

