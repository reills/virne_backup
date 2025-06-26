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
  id 919
  arrival_time 19650.25836099456
  lifetime 482.3996178082933
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 23
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 12
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 12
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 9
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 44
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 35
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
]
