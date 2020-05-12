Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E21D0334
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2020 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgELXuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 May 2020 19:50:17 -0400
Received: from mail.redfish-solutions.com ([45.33.216.244]:46096 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgELXuR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 May 2020 19:50:17 -0400
Received: from macbook2.redfish-solutions.com (macbook2.redfish-solutions.com [192.168.1.39])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 04CNoEPE032682
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 17:50:14 -0600
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1 1/1] xtables-addons: geoip: update scripts for DBIP
 names, etc.
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <nycvar.YFH.7.77.849.2005122250300.12285@n3.vanv.qr>
Date:   Tue, 12 May 2020 17:50:14 -0600
Cc:     netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <88C53F2F-CC3A-4E2C-806A-8C751953C328@redfish-solutions.com>
References: <20200512002747.2108-1-philipp@redfish-solutions.com>
 <nycvar.YFH.7.77.849.2005121118260.6562@n3.vanv.qr>
 <BC0C3307-DA4C-405E-8B3D-98A752B87EFC@redfish-solutions.com>
 <nycvar.YFH.7.77.849.2005122250300.12285@n3.vanv.qr>
To:     Jan Engelhardt <jengelh@inai.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



> On May 12, 2020, at 2:50 PM, Jan Engelhardt <jengelh@inai.de> wrote:
> 
> 
> On Tuesday 2020-05-12 18:51, Philip Prindeville wrote:
>>>> Also change the default destination directory to /usr/share/xt_geoip
>>>> as most distros use this now.  Update the documentation.
>>> 
>>> Maybe there are some "nicer" approaches? I'm calling for further inspirations.
>> 
>> I’m open to suggestions.
> 
> This has been floating around my mind.


Problem with this change is that "-D foo -s” and “-s -D foo” have different semantics… Should probably make the two options mutually exclusive.

-Philip

> 
> geoip/xt_geoip_build   | 1 +
> geoip/xt_geoip_build.1 | 8 ++++++--
> 2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/geoip/xt_geoip_build b/geoip/xt_geoip_build
> index 750bf98..7bafa5f 100755
> --- a/geoip/xt_geoip_build
> +++ b/geoip/xt_geoip_build
> @@ -24,6 +24,7 @@ my $target_dir = ".";
> &GetOptions(
> 	"D=s" => \$target_dir,
> 	"i=s" => \$input_file,
> +	"s" => sub { $target_dir = "/usr/share/xt_geoip"; },
> );
> 
> if (!-d $target_dir) {
> diff --git a/geoip/xt_geoip_build.1 b/geoip/xt_geoip_build.1
> index ac3e6d3..598177f 100644
> --- a/geoip/xt_geoip_build.1
> +++ b/geoip/xt_geoip_build.1
> @@ -27,11 +27,15 @@ Specifies the target directory into which the files are to be put. Defaults to "
> \fB\-i\fP \fIinput_file\fP
> Specifies the source location of the DBIP CSV file. Defaults to
> "dbip-country-lite.csv". Use "-" to read from stdin.
> +.TP
> +\fB\-s\fP
> +"System mode". Equivalent to \fB\-D /usr/share/xt_geoip\fP.
> .SH Application
> .PP
> -Shell commands to build the databases and put them to where they are expected:
> +Shell commands to build the databases and put them to where they are expected
> +(usually run as root):
> .PP
> -xt_geoip_build \-D /usr/share/xt_geoip
> +xt_geoip_build \-s
> .SH See also
> .PP
> xt_geoip_dl(1)
> -- 
> 2.26.2
> 

