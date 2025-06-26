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
  id 1754
  arrival_time 39123.53856826924
  lifetime 2192.1932270855277
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 12
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 21
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 22
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 2
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 19
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 9
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 46
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
]
