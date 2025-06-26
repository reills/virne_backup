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
  id 1786
  arrival_time 39808.35020548841
  lifetime 363.0189871834392
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 34
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 11
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 4
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 5
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 23
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 30
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 23
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 33
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 21
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 48
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
]
