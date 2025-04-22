graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 944
  arrival_time 20111.520164769667
  lifetime 551.8005735385075
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 13
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 40
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 18
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 45
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 41
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 46
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 30
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 7
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 20
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 35
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 17
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 41
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 27
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
]
