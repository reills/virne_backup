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
  id 1670
  arrival_time 37260.01969894736
  lifetime 122.23477998132172
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 46
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 33
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 50
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 22
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 43
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 40
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 23
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
]
