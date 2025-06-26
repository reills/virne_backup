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
  id 153
  arrival_time 2963.0012609746514
  lifetime 1913.2558849505083
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 3
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 3
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 42
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 42
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 26
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 44
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 38
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 3
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
]
